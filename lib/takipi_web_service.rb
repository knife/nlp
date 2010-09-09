require 'rubygems'
require 'savon'

class TakipiWebService
    URL = 'http://nlp.pwr.wroc.pl/clarin/ws/takipi/'
    WSDL_URL = URL + 'takipi.wsdl'
    
    def self.request(text)
        client  = Savon::Client.new WSDL_URL, :soap_endpoint => URL

       # Call remote service methods
        response =  client.tag do |soap|
            soap.body = "<text>#{text}</text><format>TXT</format><useGuesser>true</useGuesser>"
        end

        response =  response.to_hash
        token =  response[:tag_response][:tag_response][:msg]
        status = (response[:tag_response][:tag_response][:status]).to_i

         #checking status   
         timeout = 60
         step = 5
         count = 0
         loop do 
            break if count > timeout
            if status == 1
                    break
            elsif status == 2 or status == 3
                            count += 5
                            sleep(1)
                            r = client.get_status do |soap|
                                soap.body = "<token>#{token}</token>"
                            end.to_hash
                            status =  (r[:get_status_response][:status]).to_i   

            end
         end

         #geting result

        result = client.get_result do |soap|
            soap.body="<token>#{token}</token>"
        end

        response_document = result.to_hash[:get_result_response][:tag_response][:msg]

        #transforming response to well formed xml string
       return "<xml><chunkList>#{response_document}</chunkList></xml>"
    end 
end

