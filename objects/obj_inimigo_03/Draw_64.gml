/// @description desenhando na GUI

if (global.debug) //desenhando o debug do inimigo 3
{
	draw_set_font(fnt_debug);
	draw_text_colour(20, 60, "enemy life : " + string(vida), c_fuchsia, c_red, c_fuchsia, c_fuchsia, 1); //desenhando a vida
	draw_text_colour(20, 90, "enemy estate : " + string(estado), c_fuchsia, c_red, c_fuchsia, c_fuchsia, 1); //desenhando o estado
	draw_text_colour(20, 120, "enemy count : " + string(contador), c_fuchsia, c_red, c_fuchsia, c_fuchsia, 1); //desenhando o contador
	
	draw_set_font(-1);
}