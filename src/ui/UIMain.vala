using GLib;
using Gtk;

public class UIMain {

	public Gtk.Window window = new Gtk.Window ();
	public Gtk.Paned paned = new Gtk.Paned(Gtk.Orientation.HORIZONTAL);
	public Gtk.ListBox issues_list;
	public Gtk.HeaderBar headerbar;
	public Gtk.TextView textview;
	
	public void show() {
		setup_window();
		setup_paned();
		setup_issue_list();
		window.show_all ();
	}

	private void setup_issue_list() {
		issues_list = new Gtk.ListBox();
		paned.add1(issues_list);
	}

	private void setup_paned() {
		window.add(paned);
		textview = new Gtk.TextView();
		textview.buffer.text = "";
		paned.add2(textview);
	}

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

	public void add_item(string text) {
		issues_list.prepend(new Gtk.Label (text));
		issues_list.show_all();
	}

	public void set_text(string text) {
		textview.buffer.text = text;
	}

}
