shader_type canvas_item;

uniform vec4 cor_do_brilho : source_color = vec4(1.0, 1.0, 1.0, 0.8);
uniform float velocidade = 1.5; 
uniform float tamanho_faixa = 0.2; 
uniform float inclinacao = 0.5; 

void fragment() {
    vec4 cor_original = COLOR * texture(TEXTURE, UV);
    
    float tempo = mod(TIME * velocidade, 2.0) - 0.5;
    float faixa = smoothstep(tempo - tamanho_faixa, tempo, UV.x + UV.y * inclinacao) 
                - smoothstep(tempo, tempo + tamanho_faixa, UV.x + UV.y * inclinacao);
    
    COLOR = mix(cor_original, cor_do_brilho, faixa * cor_original.a);
}