class StackExchangeService
  ROOT_URL = "http://api.stackexchange.com/"
  VERSION = 2.2
  SITE_NAME = "stackoverflow"

  def self.get_questions(name)
    user = get_user_by_name(name)
    if user["items"].size > 0
      id = user["items"][0]["user_id"]
      tags = get_user_tags(id)
      url = ROOT_URL + VERSION.to_s + "/search/advanced?order=desc&sort=creation&tagged=" + tags.join(";") + "&site=" + SITE_NAME

      fetch_info(url)
    else
      return false
    end
  end

  def self.get_user_tags(id)
    url = ROOT_URL + VERSION.to_s + "/users/" + id.to_s + "/tags?pagesize=5&order=desc&sort=popular&site=" + SITE_NAME

    fetch_info(url)["items"].map{|t| t["name"]}
  end

  def self.get_user_by_name(name)
    url = ROOT_URL + VERSION.to_s + "/users?inname=" + name + "&site=" + SITE_NAME

    fetch_info(url)
  end

private
  def self.fetch_info(url)
    require "net/http"
    uri = URI.parse(URI.encode(url))
    results = Net::HTTP.get(uri)
    return JSON.parse(results)
  end
end