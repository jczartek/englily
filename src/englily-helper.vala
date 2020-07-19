/* englily-helper.vala
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

using Gee;

namespace Englily {
  public class Helper {
    private static HashMap<string, string> symbols = null;

    private static void initialize_symbols() {
      symbols = new HashMap<string, string>();
      symbols["&IPA502"] = "ˌ";
      symbols["&inodot"] = "ɪ";
      symbols["&##952"] ="θ";
      symbols["&##8747"] = "ʃ";
      symbols["&eng"] = "ŋ";
      symbols["&square"] = "…";
      symbols["&squareb"] = "•";
      symbols["&pause"] = "―";
      symbols["&##163"] = "£";
      symbols["&dots"] = "…";
      symbols["&rArr"] = "→";
      symbols["&IPA118"] = "ɲ";
      symbols["&##949"] = "ε";
      symbols["&IPA413"] = " ̟";
      symbols["&IPA424"] = " ̃";
      symbols["&IPA505"] = " ̆";
      symbols["&IPA135"] = "ʒ";
      symbols["&IPA305"] = "ɑ";
      symbols["&IPA306"] = "ɔ";
      symbols["&IPA313"] = "ɒ";
      symbols["&IPAa313"] = "ɒ";
      symbols["&IPA314"] = "ʌ";
      symbols["&IPA321"] = "ʊ";
      symbols["&IPA326"] = "ɜ";
      symbols["&IPA503"] = "ː";
      symbols["&IPA146"] = "h";
      symbols["&IPA170"] = "w";
      symbols["&IPA128"] = "f";
      symbols["&IPA325"] = "æ";
      symbols["&IPA301"] = "i";
      symbols["&IPA155"] = "l";
      symbols["&IPA319"] = "ɪ";
      symbols["&IPA114"] = "m";
      symbols["&IPA134"] = "ʃ";
      symbols["&IPA103"] = "t";
      symbols["&IPA140"] = "x";
      symbols["&IPA119"] = "ŋ";
      symbols["&IPA131"] = "ð";
      symbols["&IPA130"] = "θ";
      symbols["&schwa.x"] = "ə";
      symbols["&epsi"] = "ε";
      symbols["&ldquor"] = "“";
      symbols["&marker"] = "►";
      symbols["&IPA101"] = "p";
      symbols["&IPA102"] = "b";
      symbols["&IPA104"] = "d";
      symbols["&IPA109"] = "k";
      symbols["&IPA110"] = "g";
      symbols["&IPA116"] = "n";
      symbols["&IPA122"] = "r";
      symbols["&IPA129"] = "v";
      symbols["&IPA132"] = "s";
      symbols["&IPA133"] = "z";
      symbols["&IPA153"] = "j";
      symbols["&IPA182"] = "ɕ";
      symbols["&IPA183"] = "ʑ";
      symbols["&IPA302"] = "e";
      symbols["&IPA304"] = "a";
      symbols["&IPA307"] = "o";
      symbols["&IPA308"] = "u";
      symbols["&IPA309"] = "y";
      symbols["&IPA322"] = "ə";
      symbols["&IPA426"] = "ˡ";
      symbols["&IPA491"] = "ǫ";
      symbols["&IPA501"] = "ˈ";
      symbols["&comma"] = ",";
      symbols["&squ"] = "•";
      symbols["&ncaron"] = "ň";
      symbols["&atildedotbl.x"] = "ã";
      symbols["&rdquor"] = "”";
      symbols["&verbar"] = "|";
      symbols["&IPA405"] = " ̤";
      symbols["&idot"] = "i";
      symbols["&equals"] = "=";
      symbols["&lsqb"] = "[";
      symbols["&rsqb"] = "]";
      symbols["&s224"] = "◊";
      symbols["&karop"] = "◊";
      symbols["&s225"] = "<";
      symbols["&s241"] = ">";
      symbols["&#!0,127"] = "▫";
      symbols["&##37"] = "%";
      symbols["&##9553"] = "║";
      symbols["&oboczn"] = "║";
      symbols["&##1100"] = "ь";
      symbols["&##1098"] = "ъ";
      symbols["&s172"] = "←";
      symbols["&ytilde"] = "ỹ";
      symbols["&estrok"] = "ě";
      symbols["&ndotbl"] = "ṇ";
      symbols["&yogh"] = "ȝ";
      symbols["&ismutne"] = "i";
      symbols["&usmutne"] = "u";
      symbols["&middot_s"] = "⋅";
      symbols["&##133"] = "…";
      symbols["&semi"] = ";";
      symbols["&zacute"] = "ź";
      symbols["&dollar"] = "$";
      symbols["&frac13"] = "⅓";
      symbols["&frac15"] = "⅕";
      symbols["&ldotbl.x"] = "ḷ";
      symbols["&mdotbl.x"] = "ṃ";
      symbols["&commat"] = "@";
      symbols["&Lstrok"] = "Ł";
      symbols["&Aogon"] = "Ą";
      symbols["&ybreve.x"] = "Ў";
      symbols["&IPA177"] = "ǀ";
      symbols["&IPA324"] = "ɐ";
      symbols["&IPA432"] = " ̯";
      symbols["&IPA432i"] = "i̯";
      symbols["&IPA303"] = "ɛ";
      symbols["&IPA138"] = "ç";
      symbols["&IPA320"] = "ʏ";
      symbols["&IPA214"] = "ʤ";
      symbols["&epsilontilde"] = "ε";
      symbols["&auluk"] = "au";
      symbols["&ailuk"] = "ai";
      symbols["&apos"] = "'";
      symbols["&brvbar"] = "|";
      symbols["&reg"] = "®";
      symbols["&rsquo"] = "’";
      symbols["&lsquo"] = "‘";
      symbols["&ccedil"] = "ç";
      symbols["&eacute"] = "é";
      symbols["&egrave"] = "è";
      symbols["&amp"] = "&";
      symbols["&ecirc"] = "ê";
      symbols["&agrave"] = "à";
      symbols["&iuml"] = "ï";
      symbols["&ocirc"] = "ô";
      symbols["&icirc"] = "î";
      symbols["&para"] = "▹";
      symbols["&mdash"] = "—";
      symbols["&rdquo"] = "”";
      symbols["&ldquo"] = "“";
      symbols["&ndash"] = "–";
      symbols["&asymp"] = "\u224d";
      symbols["&ap"] = "≈";
      symbols["&rarr"] = "↪";
      symbols["&pound"] = "£";
      symbols["&aelig"] = "æ";
      symbols["&auml"] = "ä";
      symbols["&dash"] = "-";
      symbols["&uuml"] = "ü";
      symbols["&ouml"] = "ö";
      symbols["&szlig"] = "ß";
      symbols["&Auml"] = "Ä";
      symbols["&Ouml"] = "Ö";
      symbols["&Uuml"] = "Ü";
      symbols["&acirc"] = "â";
      symbols["&ndotbl.x"] = "n̩";
    }

    public static string get_html_symbol(string key) {
      if (symbols == null)
        initialize_symbols();

      var symbol = symbols[key];

      if (symbol == null)
        critical("Can't find a symbol for %s key!", key);

      return symbol;
    }
  }
}
