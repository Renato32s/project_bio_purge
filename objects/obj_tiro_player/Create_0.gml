/// @description iniciando o objeto

//variável de cor
color = c_fuchsia;

//tiro começa pequeno e fica grande
image_xscale = 1.5;
image_yscale = .8;

vspeed = -1; //iniciando com a velocidade baixa

//metodo de efeitos do tiro
efectos = function()
{
	image_xscale = lerp(image_xscale, 1.1, .1); //alterando a escala_x
	image_yscale = lerp(image_yscale, 2, .1); //alterando a escala_y
	
	vspeed = lerp(vspeed, -10, .1); //efeito de velocidade do tiro
}