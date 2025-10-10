#include "windows.h"

void	create_overlay(t_overlay o, t_img *img)
{
	t_colors	c[2];
	float		alpha;
	int		x;
	char		*pixel;

	alpha = (255 - get_opacity(o.color)) / 255.0;
	printf("%f\n", alpha);
	while (o.y_start <= o.y_end)
	{
		x = o.x_start;
		while (x <= o.x_end)
		{
			pixel = img->data + (o.y_start * img->size_line + x * (img->bpp / 8));
			c[0].red = get_r(*(unsigned int *)pixel); 
			c[0].green = get_g(*(unsigned int *)pixel); 
			c[0].blue = get_b(*(unsigned int *)pixel);
			c[1].red = get_r(o.color) * (1 - alpha) + c[0].red * alpha;
			c[1].green = get_g(o.color) * (1 - alpha) + c[0].green * alpha;
			c[1].blue = get_b(o.color) * (1 - alpha) + c[0].blue * alpha;
			*(unsigned int *)pixel = gen_trgb(0, c[1].red, c[1].green, c[1].blue);
			x++;
		}
		o.y_start++;
	}
}
