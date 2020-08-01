/* englily-dict-service.vala
 *
 * Copyright 2020 Jakub Czartek <kuba@linux.pl>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

using Gtk;
using Gydict;
using Gee;

namespace Englily {
  public class DictServiceImpl : Object, Service, DictService {
    public string service_id {get; set;}
    private Gtk.ListStore model = null;
    private DataInputStream dictionary;
    private ArrayList<uint32> offsets = new ArrayList<uint32> ();

    public DictServiceImpl(string service_id) {
      this.service_id = service_id;
    }

    public unowned TreeModel get_model() throws Error {

      if (model == null) {
        create_tree_model();
      }
      return (model as TreeModel);
    }

    private void create_tree_model() throws Error {
      open_stream();

      model = new Gtk.ListStore(1, typeof(string));

      uint16 magic = 0;
      TreeIter iter;
      string word;
      ListParser list_parser = new ListParser();
      foreach(var offset in fix_offsets()) {
        dictionary.seek(offset+0x03, SET);
        magic = dictionary.read_uint16();

        if (magic == 0x1147 || magic == 0x1148) {
          dictionary.seek(0x07, CUR);
          word = GLib.convert(dictionary.read_line(), -1, "UTF-8", "ISO8859-2");
          list_parser.string_to_parse = word;
          list_parser.parse();
          offsets.add(offset);
          model.append(out iter);
          model.@set(iter, 0, list_parser.to_string(), -1);
        }
      }
    }

    private void open_stream() throws Error {
      string key = service_id == "englily-dictionary-english-polish"
                                 ? "eng-pl-path"
                                 : "pl-eng-path";
      string path = Config.get_path(key);

      var @in = File.new_for_path(path)
                    .read();
      dictionary = new DataInputStream(@in);
      dictionary.byte_order = LITTLE_ENDIAN;
    }

    private ArrayList<uint32> fix_offsets() throws Error
    {
      var fixed_offsets = new ArrayList<uint32>();

      uint32 number_of_words, base_index, base_index_words;
      number_of_words = base_index = base_index_words = 0;

      dictionary.seek(0x68, SET);
      number_of_words = dictionary.read_uint32();
      base_index = dictionary.read_uint32();
      dictionary.seek(0x04, CUR);
      base_index_words = dictionary.read_uint32();
      dictionary.seek(base_index, SET);

      for(uint32 i = 0, offset = 0; i < number_of_words; i++) {
        offset = (dictionary.read_uint32() & 0x07ffffff) + base_index_words;
        fixed_offsets.add(offset);
      }

      return fixed_offsets;
    }

    public string get_lexical_unit(uint idx) throws Error requires (idx <= offsets.size) {
      const int MaxLen = 1024 * 90;
      const int Offset = 12;
      uint8[] out_buffer;
      dictionary.seek(this.offsets[(int)idx], SET);

      var data = (dictionary as InputStream).read_bytes(MaxLen);

      int count_bytes = 0;
      for (int i = Offset; i < MaxLen; i++)
      {
        if (data.get(i) == '\0') break;
        count_bytes++;
      }
      var index = Offset + count_bytes + 2;

      if (data.get(index) < 20)
      {
        var converter = new ZlibDecompressor (ZLIB);
        out_buffer = new uint8[MaxLen];
        size_t bytes_read;
        size_t bytes_write;

        index += data.get(index) + 1;
        converter.convert(data.get_data()[index:MaxLen-1], 
                         out_buffer, NONE, 
                         out bytes_read,
                         out bytes_write);
      }
      else
      {
        out_buffer = data.get_data()[index:MaxLen-1];
      }
      
      return GLib.convert((string)out_buffer, -1, "UTF-8", "ISO8859-2");
    }

    public unowned string get_service_id() {
      return service_id;
    }

    public DictFormatter get_formatter() {
      return DictFormatterImpl.create();
    }
  }
}
