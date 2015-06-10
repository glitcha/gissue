namespace Gissue {

	public class UIIssueRow : Gtk.ListBoxRow {

		private Gtk.Label title_label;
		private Gtk.Label number_label;
		private Gtk.Label created_on_label;
		public GitHubAPIIssue issue;
		
		public void load(GitHubAPIIssue issue) {

			this.issue = issue;

			number_label = new Gtk.Label ("#" + this.issue.number.to_string());
			number_label.get_style_context ().add_class ("h3");
			//number_label.xalign = 0;
			number_label.ellipsize = Pango.EllipsizeMode.END;

			created_on_label = new Gtk.Label (this.issue.get_created_at_formated());
            //created_on_label.xalign = 0;
            created_on_label.opacity = 0.8;
            created_on_label.ellipsize = Pango.EllipsizeMode.END;
            created_on_label.use_markup = true;
            created_on_label.halign = Gtk.Align.END;
            created_on_label.margin_right = 6;

			title_label = new Gtk.Label (this.issue.title);
			//title_label.xalign = 0;
			title_label.ellipsize = Pango.EllipsizeMode.END;
			title_label.opacity = 0.8;
			title_label.expand = true;

			var grid = new Gtk.Grid ();
			grid.margin_top = 6;
			grid.row_spacing = 4;
			grid.column_spacing = 2;
			grid.attach (number_label, 0, 0, 1, 1);
			grid.attach (created_on_label, 1, 0, 1, 1);
			grid.attach (title_label, 0, 1, 2, 1);
			grid.attach (new Gtk.Separator (Gtk.Orientation.HORIZONTAL), 0, 3, 4, 1);

			this.add (grid);
			this.show_all();
		}
	}
}