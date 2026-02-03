/// @description desenhando no objeto


draw_self(); //se desenha

gpu_set_blendmode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y - 2, 1.2, 1.5, 0, color, .8);
gpu_set_blendmode(bm_normal);