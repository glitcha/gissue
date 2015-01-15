using Gee;

namespace Gissue {

	class GitHubAPI {

		public static ArrayList<GitHubAPIIssue> get_issues() {

			ArrayList<GitHubAPIIssue> issues = new ArrayList<GitHubAPIIssue> ();

			string url = "https://api.github.com/repos/vmg/redcarpet/issues";

			var session = new Soup.SessionSync ();
			var message = new Soup.Message ("GET", url);
			var outstr = "";

			message.request_headers.append("User-Agent", "gissue");
			session.send_message (message);

			var parser = new Json.Parser ();
			parser.load_from_data ((string) message.response_body.flatten ().data, -1);

			var root_object = parser.get_root ().get_array ();
				 
			foreach (var geonode in root_object.get_elements ()) {
				var json_object = geonode.get_object();
				GitHubAPIIssue issue = new GitHubAPIIssue();
				issue.title = json_object.get_string_member("title");
				issues.add(issue);
			}

			return issues;
		}
	}
}