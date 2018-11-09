# frozen_string_literal: true

#
# Custom jenkins_credentials matcher
#

class JenkinsSecretTextCredentials < JenkinsCredentials
  attr_reader :description

  name 'jenkins_secret_text_credentials'

  def initialize(description)
    @description = description
  end

  def has_secret?
    return false unless xml

    try { !!xml.elements['secret'].text }
  end

  def to_s
    "Jenkins Text Credentials #{description}"
  end

  private

  def xml
    return @xml if @xml

    @xml = REXML::XPath.first(doc, "//*[description/text() = '#{description}']/")
  end
end
