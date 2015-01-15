using Gee;
using GLib;

namespace Gissue {

	public class GitHubAPI {

		public static ArrayList<GitHubAPIIssue> get_issues() 
		{

			ArrayList<GitHubAPIIssue> issues = new ArrayList<GitHubAPIIssue> ();

			string url = "https://api.github.com/repos/vmg/redcarpet/issues";

			var session = new Soup.SessionSync ();
			var message = new Soup.Message ("GET", url);
			
			message.request_headers.append("User-Agent", "gissue");
			session.send_message (message);

			var parser = new Json.Parser ();
			parser.load_from_data ((string) message.response_body.flatten ().data, -1);

			var root_object = parser.get_root ().get_array ();
				 
			foreach (var geonode in root_object.get_elements ()) {

				var json_object = geonode.get_object();

				GitHubAPIIssue issue = new GitHubAPIIssue();

				issue.id = 			(int) json_object.get_int_member("id");
				issue.title = 		json_object.get_string_member ("title");
				issue.updated_at = 	json_object.get_string_member ("updated_at");
				issue.created_at = 	json_object.get_string_member ("created_at");
				issue.number = 		(int) json_object.get_int_member ("number");

				issues.add(issue);
			}

			return issues;
		}

		public static DateTime get_datetime_from_iso8601(string iso) 
		{	
			TimeVal timeval = TimeVal();
			timeval.from_iso8601 (iso);
			
			//DateTime datetime = 

			return new DateTime.from_timeval_utc (timeval);
		}
	}
}