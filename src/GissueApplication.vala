using GLib;
using Gtk;
using Gee;

class GissueApplication : Gtk.Application {

	public const string NAME = "Gissue";
	public const string PRGNAME = "gissue";

	public GissueApplication(string[] args) {

		// setup gtk
		Gtk.init (ref args);
		Gtk.Settings.get_default().set("gtk-application-prefer-dark-theme", true);

		// load the main window
		UIMain uimain = new UIMain();
		uimain.show();
		
		// load the issues
		ArrayList<GitHubAPIIssue> issues = GitHubAPI.get_issues();
		foreach (GitHubAPIIssue issue in issues) {
			uimain.add_item(issue.title);			
		}
	
		// run gtk
		Gtk.main ();
	}


} 