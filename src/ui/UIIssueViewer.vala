namespace Gissue {

	public class UIIssueViewer : Gtk.Box {

		public WebKit.WebView web_view;
		public Gtk.ScrolledWindow view_scroll;
		public Gtk.Viewport view_port;
		
		public UIIssueViewer () {

			web_view = new WebKit.WebView();
			web_view.open ("http://www.google.com");

			view_scroll = new Gtk.ScrolledWindow (null, null);
			view_scroll.hscrollbar_policy = Gtk.PolicyType.NEVER;
			this.add (view_scroll);

			view_port = new Gtk.Viewport (null, null);
			view_port.add (web_view);
			view_scroll.add (view_port);			
		}

		/**
		 * Process the frontmatter of a markdown document, if it exists.
		 * Returns the frontmatter data and strips the frontmatter from the markdown doc.
		 *
		 * @see http://jekyllrb.com/docs/frontmatter/
		 */
		private string[] process_frontmatter (string raw_mk, out string processed_mk) {
			string[] map = {};

			processed_mk = null;

			// Parse frontmatter
			if (raw_mk.length > 4 && raw_mk[0:4] == "---\n") {
				int i = 0;
				bool valid_frontmatter = true;
				int last_newline = 3;
				int next_newline;
				string line = "";
				while (true) {
					next_newline = raw_mk.index_of_char('\n', last_newline + 1);
					if (next_newline == -1) { // End of file
						valid_frontmatter = false;
						break;
					}
					line = raw_mk[last_newline+1:next_newline];
					last_newline = next_newline;

					if (line == "---") { // End of frontmatter
						break;
					}

					var sep_index = line.index_of_char(':');
					if (sep_index != -1) {
						map += line[0:sep_index-1];
						map += line[sep_index+1:line.length];
					} else { // No colon, invalid frontmatter
						valid_frontmatter = false;
						break;
					}

					i++;
				}

				if (valid_frontmatter) { // Strip frontmatter if it's a valid one
					processed_mk = raw_mk[last_newline:raw_mk.length];
				}
			}

			if (processed_mk == null) {
				processed_mk = raw_mk;
			}

			return map;
		}

		private string process (string raw_mk) {
			string processed_mk;
			process_frontmatter (raw_mk, out processed_mk);

			var mkd = new Markdown.Document (processed_mk.data);
			mkd.compile ();

			string result;
			mkd.get_document (out result);

			string html = "<html><head>";
			if (prefs.render_stylesheet) {
				html += "<style>"+render_stylesheet+"</style>";
			}
			if (prefs.render_syntax_highlighting) {
				html += "<style>"+syntax_stylesheet+"</style>";
				html += "<script>"+syntax_script+"</script>";
				html += "<script>hljs.initHighlightingOnLoad();</script>";
			}
			html += "</head><body><div class=\"markdown-body\">";
			html += result;
			html += "</div></body></html>";

			return html;
		}
	}
}