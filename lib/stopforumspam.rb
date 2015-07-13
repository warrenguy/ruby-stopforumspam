require 'ipaddr'
require 'xmlsimple'
require 'open-uri'

module StopForumSpam
  class Check
    def initialize(checks = [])
      @checks = parse_checks([*checks])
    end

    def result
      @result ||= do_check
    end

    def spammer?
      result.map{|type, checks| checks}.flatten.map{|check| check['appears']}.include? '1'
    end

    private

    def do_check
      response = XmlSimple.xml_in(
        open(
          'http://api.stopforumspam.org/api?' + 
          @checks.map{|check| "#{check[:type]}[]=#{check[:check]}"}.join('&')
        ), 
        { 'ForceArray' => false }
      )

      raise "Unsuccesful response from API" unless response['success'] && (response.delete('success') == '1')

      return response
    end

    def parse_checks(checks)
      raise ArgumentError, 'At least one argument required' if checks.length < 1
      return checks.map{|check|
        case check.class.to_s
        when 'String'
          {check: check, type: check_type(check)}
        when 'Hash'
          {check: check[:check], type: (check[:type] || check_type(check[:check]))}
        end
      }
    end

    def check_type(check)
      return 'email' if check =~ /.*@.*/

      begin
        check_ip = IPAddr.new(check)
        return 'ip' if check_ip.ipv4? or check_ip.ipv6?
      rescue IPAddr::InvalidAddressError
      end

      return 'username'
    end
  end
end
