using Sockets

function conecta(c, cn)
	println("\n[#] Client #$cn Received!")
 	request = readline(c)
 	println("[-] Cliente Request: ", request)
 	
 	host = strip(split(split(request, ":")[1])[2])
 	port = parse(Int32, strip(split(split(request, ":")[2])[1]))

 	s = connect(host, port)

 	write(c, "HTTP/1.1 200 Established\r\n\r\n") # Send 200 OK to Client.
 	
 	@async while true
 		# Download
 		data = readavailable(s)
 		length(data) == 0 ? break : Nothing
 		write(c, data)
 	end

 	while true
 		# Upload
 		data = readavailable(c)
 		length(data) == 0 ? break : Nothing
 		write(s, data)
 	end

 	println("[!] Client #$cn Disconnected!")
end

# Listen.
l = listen(ip"127.0.0.1", 8088)

println("[-] Listen on IP and Port: 127.0.0.1:8088")

cn = -1

while true
	global cn += 1
	c = accept(l)
	atendimento() = conecta(c, cn)
	schedule(Task(atendimento))
end