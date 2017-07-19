require 'json'
require 'rest-client'
require 'colorize'

$base_url = "localhost:3000"
$email = nil
$password = nil
$uid = nil
$rcount = 0

def parse_reponse(response)
  $response = response
  $headers = $response.headers
  $access_token = $headers[:access_token]
  $client = $headers[:client]
  $data = JSON.parse!($response.body)

  puts "#{$rcount}) response: #{$response.inspect}".cyan
  puts "#{$rcount}) headers: #{$headers.inspect}".cyan
  puts
  puts "#{$rcount}) data: #{$data}".blue
  puts
end

def request(type, path, payload=nil)
  $rcount += 1

  headers = {
    uid: $uid,
    client: $client,
    access_token: $access_token
  }

  url = "#{$base_url}/#{path}"

  puts "#{$rcount}) [#{type}] [#{path}] [#{payload}] ([#{headers}])".green
  puts

  case type
    when :post, :put
      RestClient.send(type, url, payload, headers) do |response, request, result|
        parse_reponse(response)
      end
    when :get, :delete
      RestClient.send(type, url, headers) do |response, request, result|
        parse_reponse(response)
    end
  end
end

def sign_in(email, password)
  $email = email
  $password = password
  $uid = $email
  request(:post, "auth/sign_in", {"email": $email, "password": $password})
end

def sign_out
  request(:delete, "auth/sign_out")
end

sign_in("r0@null.com", "password")
request(:get, "users")
sign_out

sign_in("m0@null.com", "password")
request(:get, "users")
sign_out

sign_in("a0@null.com", "password")
request(:get, "users")

request(:get, "users/1")

request(:put, "users/1", {user: {first_name: "blah"}})

request(:post, "users",
        { user: {
            first_name: "api",
            last_name: "user",
            email: "apiuser6@null.com",
            password: "password",
            role: "regular"
          }
        }
       )

sign_out
