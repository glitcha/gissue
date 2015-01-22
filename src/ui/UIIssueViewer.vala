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
	}
}