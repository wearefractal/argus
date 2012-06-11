start
  = command:command { return command; }

command
  = head:task tail:(":" task)* {
      var result = {};
      result[head[0]] = head[1];
      for (var i = 0; i < tail.length; i++) {
        result[tail[i][1][0]] = tail[i][1][1];
      }
      return result;
    }

task
  = name:name arg:arguments { return [name.join(""), arg]; }
  / name:name { return [name.join(""), []]; }

arguments
  = "[" "]" { return []; }
  / "[" chars:[^\]]+ "]" { return chars.join(""); }

name
  = alphanumeric+

alphanumeric
  = [a-z0-9_]i