var netStream, fileStream, netStatus : int
var netString, netAddr : string

netStatus := 200

loop
    netStream := Net.WaitForConnection (80, netAddr)
    loop
	if Net.LineAvailable (netStream) then
	    get : netStream, netString : *
	    %put netString
	else
	    exit
	end if
    end loop

    put Time.Date, " - ", netAddr, " - ", netStatus

    open : fileStream, "htdocs/index.html", get
    put : netStream, "HTTP/1.1 200 OK"
    put : netStream, "Content-Type: text/html"
    put : netStream, ""
    loop
	get : fileStream, netString : *
	put : netStream, netString
	exit when eof (fileStream)
    end loop
    Net.CloseConnection(netStream)
end loop
