using GLib;
using Gtk;
using Soup; 
using Gissue;

int main (string[] args) {

    Gtk.init (ref args);
	GissueApplication app = new GissueApplication ();
	return app.run (args);
}

