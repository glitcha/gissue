using GLib;
using Gtk;
using Gee;

namespace Gissue {

	class GissueApplication : Granite.Application {

		public const string NAME = "Gissue";
		public const string PRGNAME = "gissue";

		public GissueApplication() {

			program_name = "Gissue";


		}

		protected override void activate () {
			
			// setup gtk
			Gtk.Settings.get_default ().set("gtk-application-prefer-dark-theme", true);

			// load the main window
			UIMain uimain = new UIMain ();
			uimain.show();
			
			// load the issues
			ArrayList<GitHubAPIIssue> issues = GitHubAPI.get_issues ();
			foreach (GitHubAPIIssue issue in issues) {
				uimain.add_item (issue.title);			
			}
		
			// run gtk
			Gtk.main ();
		}
	} 

}