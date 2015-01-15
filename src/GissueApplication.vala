using GLib;
using Gtk;
using Gee;

namespace Gissue {

	public class GissueApplication : Granite.Application {

		public const string NAME = "Gissue";
		public const string PRGNAME = "gissue";

		public GissueApplication() {

			program_name = "Gissue";
			Granite.Services.Logger.initialize (program_name);
			Granite.Services.Logger.DisplayLevel = Granite.Services.LogLevel.DEBUG;
			Granite.Services.Logger.notification ("Application Started");
		}

		protected override void activate () {
			
			// setup gtk
			//Gtk.Settings.get_default ().set("gtk-application-prefer-dark-theme", true);

			// load the main window
			UIMain uimain = new UIMain ();
			uimain.show();
			
			// load the issues
			ArrayList<GitHubAPIIssue> issues = GitHubAPI.get_issues ();
			uimain.load_issues (issues);
		
			// run gtk
			Gtk.main ();
		}
	} 

}