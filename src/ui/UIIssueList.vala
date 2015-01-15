using Gee;

namespace Gissue {

	public class UIIssueList : Gtk.Box {

		public Gtk.ListBox issues_box;
		public Gtk.ScrolledWindow view_scroll;
		public Gtk.Viewport view_port;
		public ArrayList<GitHubAPIIssue> issues;
		public Gtk.Label test_label;

		public UIIssueList () {

			issues_box = new Gtk.ListBox ();

			view_scroll = new Gtk.ScrolledWindow (null, null);
            view_scroll.hscrollbar_policy = Gtk.PolicyType.NEVER;
			this.add (view_scroll);

			view_port = new Gtk.Viewport (null, null);
			view_port.add (issues_box);
			view_scroll.add (view_port);

			issues_box.show_all();
			this.show_all();
		}

		public void load (ArrayList<GitHubAPIIssue> issues) {

			this.issues = issues;

			foreach (GitHubAPIIssue issue in issues) {
				var row = new UIIssueRow ();
				row.load (issue);
				issues_box.add (row);
			}
			issues_box.show_all();
			this.show_all();
		}
	}
}