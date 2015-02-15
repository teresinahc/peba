require 'net/http'

Net::HTTP.start("static.flickr.com") { |http|
  resp = http.get("/92/218926700_ecedc5fef7_o.jpg")
  open("fun.jpg", "wb") { |file|
    file.write(resp.body)
   }
}
puts "Yay!!"