using GLib;
using Gtk;
using Gee;

namespace Gissue {

	public class UIMain {

		public Gtk.Window window = new Gtk.Window ();
		public Gtk.Paned paned;
		public UIIssueList issues_list;
		public UIIssueViewer issue_view;
		public Gtk.HeaderBar headerbar;
		public Gtk.TextView textview;
		public Gtk.Paned tpaned;
		public Granite.Widgets.SourceList sourcelist;
		
		public void show() {
			setup_window();
			setup_paned();
			//setup_issue_list();
			window.show_all ();
		}

		public void load_issues(ArrayList<GitHubAPIIssue> issues) {
			issues_list.load (issues);
		}

		private void on_issue_list_change (UIIssueRow issue_row) {
			issue_view.render (issue_row.issue.body);
		}

		private void setup_paned() {
			
			sourcelist = new Granite.Widgets.SourceList ();
			tpaned = new Gtk.Paned (Gtk.Orientation.HORIZONTAL);
			tpaned.position = 100;
			paned = new Gtk.Paned(Gtk.Orientation.HORIZONTAL);
			paned.position = 300;

			tpaned.pack1 (sourcelist, true, true);
			
			// issues list
			issues_list = new UIIssueList ();
			issues_list.changed_event_signal.connect (on_issue_list_change);
			paned.add1 (issues_list);

			// issue viewer
			issue_view = new UIIssueViewer ();
			paned.add2 (issue_view);
			tpaned.pack2 (paned, true, true);

			window.add (tpaned);
		}

		// private void setup_side_bar() {
			
		// }

		private void setup_window() {

			// header bar
			headerbar = new Gtk.HeaderBar();
			headerbar.show_close_button = true;	

			// window setup
			window.set_titlebar(headerbar);
			window.title = "Gissue";
			window.set_border_width (0);
			window.set_position (Gtk.WindowPosition.CENTER);
			window.set_default_size (800, 600);
			window.destroy.connect (Gtk.main_quit);
		}

		// public void add_item(string text) {
		// 	issues_list.prepend(new Gtk.Label (text));
		// 	issues_list.show_all();
		// }

		public void set_text(string text) {
			textview.buffer.text = text;
		}

	}
}