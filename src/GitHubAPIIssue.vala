using Gee;
using GLib; 

namespace Gissue {

	public class GitHubAPIIssue {

		public string url;
		public int id;
		public int number;
		public string title;
		public string created_at;
		public string updated_at;
		public int comments;
		public string body;

		public string get_created_at_formated () {
		
			DateTime datetime = GitHubAPI.get_datetime_from_iso8601 (this.created_at);
		
			return datetime.format("%e %b %Y");
		}
	}
}