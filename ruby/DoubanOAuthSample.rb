# -----------------------------------------------------------------
# �������ṩ�������Douban OAuth��֤��Rubyʾ������
# �����������԰汾��Douban OAuth��֤ʾ�������� http://code.google.com/p/douban-oauth-sample/ ���ṩ
# ���κ����ʣ����Ե� http://www.douban.com/group/dbapi/ ������
# -----------------------------------------------------------------

# Douban OAuth��֤���������Ĳ�����
# 
# 1. ��ȡRequest Token
# 2. �û�ȷ����Ȩ
# 3. ��ȡAccess Token
# 4. ����������Դ
     
gem 'oauth'
require 'oauth/consumer'

api_key = ""
api_key_secret = ""

@consumer=OAuth::Consumer.new api_key, 
                              api_key_secret, 
                              {:site=>"http://www.douban.com",
                                :request_token_path=>"/service/auth/request_token",
                                :access_token_path=>"/service/auth/access_token",
                                :authorize_path=>"/service/auth/authorize"
                              }

puts "1. ��ȡRequest Token"
@request_token=@consumer.get_request_token

puts "2. �û�ȷ����Ȩ"
puts "�뽫����urlճ����������У���ͬ����Ȩ��ͬ������������:"
puts @request_token.authorize_url
gets

puts "3. ��ȡAccess Token"
@access_token=@request_token.get_access_token

# i should re-generate access_token proxy here, 
# since ruby oauth library assume the domain of the auth site should be same with the resource site
@access_token = OAuth::AccessToken.new OAuth::Consumer.new(api_key,  
                                                                      api_key_secret, 
                                                                      {:site=>"http://api.douban.com"}),
                                                                @access_token.token,
                                                                @access_token.secret

puts "4. ����������Դ"
@response=@access_token.post "/miniblog/saying", %q{<?xml version='1.0' encoding='UTF-8'?>
  <entry xmlns:ns0="http://www.w3.org/2005/Atom" xmlns:db="http://www.douban.com/xmlns/">
    <content>Ruby OAuth Authorized</content>
  </entry>
},  {"Content-Type" =>  "application/atom+xml"}