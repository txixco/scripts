;	***************************************
;	* Common Global Variables & Functions *
;	***************************************

;Menu TRAY, Icon, %ForcePharmaDir%\ForcePharma.exe
#SingleInstance ignore
#Hotstring oc
#Hotstring EndChars `t 

;	**************
;	* Hotstrings *
;	**************

::ul::<ul>{Enter 2}</ul>{Up}
::ol::<ol>{Enter 2}</ol>{Up}
::li::<li></li>{Left 5}
::co::<code></code>{Left 7}
::p::<p></p>{Left 4}
::str::<strong></strong>{Left 9}
::em::<em></em>{Left 5}
::h1::<h1></h1>{Left 5}
::h2::<h2></h2>{Left 5}
::h3::<h3></h3>{Left 5}
::h4::<h4></h4>{Left 5}
::html::<html>{Enter 2}</html>{Up}
::head::<head>{Enter 2}</head>{Up}
::body::<body>{Enter 2}</body>{Up}

::br::<br />
::div::<div></div>{Left 6}
::cmt::<{!}--  -->{Left 4}
::hr::<hr />

::tab::<table>{Enter 2}</table>{Up}
::tr::<tr>{Enter 2}</tr>{Up}
::td::<td></td>{Left 5}

::skel::<html>{Enter}<head>{Enter}<title></title>{Enter}</head>{Enter}<body>{Enter 2}</body>{Enter}</html>

::abbr::
	SendInput <abbr title="%clipboard%"></abbr>{Left 7}
	return

::href::
	SendInput <a class="enlace" href="%clipboard%" target="_blank"></a>{Left 4}
	return
::mail::
	SendInput <a href="mailto:%clipboard%"></a>{Left 4}
	return
::bk::
	SendInput <blockquote>%clipboard%</blockquote>
	return

::img::
SendInput 
(
<div style="float: center;">
	<img style="margin: 0pt 10pt 0px 0px;" src="%clipboard%" alt="" />
</div>
){Up}{End}{Left 4}
return

::imgl::
SendInput 
(
<div style="float: left;">
	<img style="margin: 0pt 10pt 0px 0px;" src="%clipboard%" alt="" />
</div>
){Up}{End}{Left 4}
return

::imgr::
SendInput 
(
<div style="float: right;">
	<img style="margin: 0pt 10pt 0px 0px;" src="%clipboard%" alt="" />
</div>
){Up}{End}{Left 4}
return

::emot::
	SendInput <img class="emoticono" src="%clipboard%" />
	return

#include programacion.ahk