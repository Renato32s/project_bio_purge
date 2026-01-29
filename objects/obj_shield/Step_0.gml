/// @description controla o objeto

//fazendo o objeto se destruir se já acabou a animação
if (image_index <= 0.3 and image_speed <= 0) //se o image_index for menor ou igual 0.2
{
	instance_destroy(); //se destruindo
}