
using Sockets

function connect1(c)
    println("[-]Cliente Recebido!")
    request = readline(c)
    println([#] Cliente request $request)

    host = strip(split(split(request,":")[1])[2])
    port = parse(Int32, strip(split(split(request, ":")[2])[1]))

    s = connect(host, port)

    write(c, "HTTP/1.1 200 estabilisged")

    while true
        # Upload
        data = readavailable()
        length(data) == 0 ? break : Nothing
        write(s, data)
    and

    

and

l = listen(ip"127.0.0.1,8080)
println([-] Listen on IP and Port 127.0.0.1:8080)

while true
    c = aceept(l)
    atendimento() = connect1(c)
    schedule(Task(atendimento))
and