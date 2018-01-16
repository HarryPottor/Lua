function fwrite(fmt, ... )
    return io.write(string.format(fmt, ...));
end

function BEGIN()
    io.write([[
        <html>
        <head><title>projects using lua</title></head>
        <body bgcolor="#FFFFFF">
        Here are brief descriptions of some projects around the
        world that use <a href="home.html">Lua</a>
        <br>
        ]])
end

function entry1(o)
    count = count + 1;
    local title = o.title or "(no title)"
    fwrite("<li><a href='#%d'>%s</a>\n", count, title );
end

function entry2 (o)
    count=count + 1;
    local title = o.title or o.org or 'org'
    fwrite('<HR>\n<H3>\n')
    local href = ''
    if o.url then
        href = string.format(' HREF="%s"', o.url)
    end
    fwrite('<A NAME="%d"%s>%s</A>\n', count, href, title)
    if o.title and o.org then
        fwrite('\n<SMALL><EM>%s</EM></SMALL>', o.org)
    end
    fwrite('\n</H3>\n')
    if o.description then
        fwrite('%s', string.gsub(o.description,
            '\n\n\n*', '<P>\n'))
        fwrite('<P>\n')
    end
    if o.email then
        fwrite('Contact: <A HREF="mailto:%s">%s</A>\n',
        o.email, o.contact or o.email)
    elseif o.contact then
        fwrite('Contact: %s\n', o.contact)
    end
end

function END()
fwrite('</BODY></HTML>\n')
end


local inputfile = 'db.lua';
BEGIN();
count = 0;

f = loadfile(inputfile);
entry = entry1;
fwrite('<ul>\n');
f();
fwrite('</ul>\n');

count = 0;
entry = entry2;
f();

END();
