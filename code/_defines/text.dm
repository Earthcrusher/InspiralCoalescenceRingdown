#define capitalize(_text) uppertext(copytext(_text, 1, 2)) + copytext(_text, 2)

/proc/trim_left(text)
	for (var/i = 1 to length(text))
		if (text2ascii(text, i) > 32)
			return copytext(text, i)
	return ""

/proc/trim_right(text)
	for (var/i = length(text), i > 0, i--)
		if (text2ascii(text, i) > 32)
			return copytext(text, 1, i + 1)
	return ""

/proc/trim(text)
	return trim_left(trim_right(text))

/proc/FormatForDisplay(var/string)
	string = trim(string)
	var/ending = copytext(string, length(string))
	if(ending != "!" && ending != "?" && ending != ".")
		string += "."
	return string

/proc/BreakStringIntoPerformedComponents(var/string)
	var/first_paren = findtext(string, "(")
	var/second_paren = findtext(string, ")")
	if(first_paren != 0 && second_paren != 0)
		return list(copytext(string, first_paren+1, second_paren), copytext(string, second_paren+2))
	else
		return list("", string)

/proc/EnglishList(var/list/items)
	var/final_string = ""
	for(var/i = 1 to items.len)
		if(i == items.len)
			final_string += " and [items[i]]"
		else if(i != 1)
			final_string += ", [items[i]]"
		else
			final_string = items[i]
	return final_string

/proc/Encode(var/string)
	return md5(string) // this is not at all secure
	//return call("password_encoding_lib.dll","encode")(string)
