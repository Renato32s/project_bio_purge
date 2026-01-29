/// @description desenha na tela do game

#region desenhando o deug
draw_set_font(fnt_debug); //setando a fonte do debug
//desenhando o debug do level
var _debug = keyboard_check_pressed(vk_tab); //se pressionar tab, o debug aparece
if (_debug)
{
	global.debug = !global.debug;
}
if (global.debug) //se o debug for true
{
	var _text = "level : " + string(level_shoot); //desenha na tela
	draw_text_colour(20, 20, _text, c_fuchsia, c_red, c_fuchsia, c_fuchsia, 1);
}

draw_set_font(-1); //resetando o draw_set

#endregion

//desenhando os icones de vida e escudo
desenha_gui(spr_icon_vidas, vidas, 20, 20, +30, .4); //desenhando o icone de vidas
desenha_gui(spr_icon_escudos, escudos, 20, 45, +30, .4); //desenhando o icone de escudos

