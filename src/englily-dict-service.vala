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
using Gy;
using Gee;


namespace Englily {
  public class DictServiceImpl : Object, Service, DictService {

    public string service_id { get; private set; }

    private TreeModel? model;
    private DataInputStream data_stream;
    private ArrayList<uint32> offsets = new ArrayList<uint32> ();

    public DictServiceImpl(string service_id) {
      this.service_id = service_id;
    }

    public unowned TreeModel get_model() throws Error {

      if (model == null) {
        create_tree_model();
      }
      return model;
    }

    private void create_tree_model() throws Error {
      open_read_stream();
      set_offsets();
    }

    private void open_read_stream() throws Error {
      string key = service_id == "englily-dictionary-english-polish"
                                 ? "eng-pl-path"
                                 : "pl-eng-path";
      string path = Config.get_path(key);

      var @in = File.new_for_path(path)
                    .read();
      data_stream = new DataInputStream(@in);
      data_stream.byte_order = LITTLE_ENDIAN;
    }

    private void set_offsets() throws Error requires(data_stream is DataInputStream) {

      uint32 number_of_words, base_index, base_index_words;
      number_of_words = base_index = base_index_words = 0;

      data_stream.seek(0x68, SET);
      number_of_words = data_stream.read_uint32();
      base_index = data_stream.read_uint32();
      data_stream.seek(0x04, CUR);
      base_index_words = data_stream.read_uint32();
      data_stream.seek(base_index, SET);

      for(uint32 i = 0, offset = 0; i < number_of_words; i++) {
        offset = (data_stream.read_uint32() & 0x07ffffff) + base_index_words;
        offsets.add(offset);
      }
    }

    public string get_lexical_unit(uint idx) {
      return "";
    }

    public unowned string get_service_id() {
      return service_id;
    }
  }
}
