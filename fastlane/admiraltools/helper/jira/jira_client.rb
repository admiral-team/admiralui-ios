require 'jira-ruby'
require_relative '../admiraltools_helper'

class JiraClient
  def initialize(options:)
    @client = JIRA::Client.new(options)
  end

  def get_issues(params:, fields:)
    jql_search = jql_string(params)
    @client.Issue.jql(jql_search, fields: fields)
  end

  def find_issue(params:)
    @client.Issue.find(params[:issue])
  end

  def add_comment(params:)
    issue = find_issue(params: params)
    attachment_path = params[:attachment]

    unless attachment_path.nil?
      attachment = issue.attachments.build
      attachment.save('file': attachment_path)
    end

    comment = issue.comments.build
    comment.save!(body: params[:comment_body])
  end

  def separate_release_issues(jql_params:, close_status:, issue_fields: nil)
    closed_issues_params = jql_params.clone
    closed_issues_params[:status] = close_status

    issue_fields = issue_fields || %i[
      key
      status
    ]

    all_issues = get_issues(params: jql_params, fields: issue_fields)
    closed_issues = get_issues(params: closed_issues_params, fields: issue_fields)

    all_keys = all_issues.map { |n| n.key }
    closed_keys = closed_issues.map { |n| n.key }
    opened_keys = all_keys - closed_keys
    opened_issues = all_issues.select { |element| opened_keys.include? element.key }

    { "closed": closed_issues, "opened": opened_issues }
  end

  def add_version(version_attrs:)
    version = @client.Version.build
    version.save(version_attrs)
  end

  def replace_version(project:, name:, version_attrs:)
    versions = @client.Project
                      .find(project).versions
                      .select { |v| v.name == name }

    raise "No version \"#{name})\" found in project \"#{project}\"" if versions.empty?

    versions[0].save(version_attrs)
  end

  def self.jira_extract_name(text:, prefix:)
    text.match("#{prefix}-[0-9]*") || []
  end

  private

  def jql_string(params)
    jql = params[:jql]
    project = params[:project]
    issue = params[:issue]
    summary = params[:summary]
    fix_version = params[:fix_version]
    resolution = params[:resolution]
    status = params[:status]
    assignee = params[:assignee]
    labels = params[:labels] || []

    return jql unless jql.nil?

    jql = ''
    jql += " AND project = \"#{project}\"" unless project.nil?
    jql += " AND issue = \"#{issue}\"" unless issue.nil?
    jql += " AND summary ~ \"#{summary}\"" unless summary.nil?
    jql += " AND fixVersion = \"#{fix_version}\"" unless fix_version.nil?
    jql += " AND resolution = \"#{resolution}\"" unless resolution.nil?
    jql += " AND status = \"#{status}\"" unless status.nil?
    jql += " AND assignee = \"#{assignee}\"" unless assignee.nil?
    labels.each { |l| jql += " AND labels = \"#{l}\"" }

    jql.delete_prefix(' AND ')
  end
end
