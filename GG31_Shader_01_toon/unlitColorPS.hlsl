//�s�N�Z���V�F�[�_�[
#include "common.hlsl"

//�e�N�X�`��
Texture2D		g_Texture : register(t0);		//�e�N�X�`��0�Ԃ��g��
//�T���v���[
SamplerState	g_SamplerState : register(s0);	//�T���v���[0�Ԃ��g��

void main(in PS_IN In, out float4 outDiffuse : SV_Target)
{
#define TEXTURECOLOR g_Texture.Sample(g_SamplerState, In.TexCoord);
	//���͂��ꂽ�F�����̂܂܃s�N�Z���F�Ƃ��ďo��
	//outDiffuse = In.Diffuse;
	//outDiffuse = float4(1.0f, 0.0f, 1.0f, 1.0f);

	//���͂��ꂽ�e�N�X�`�����W�����ƂɃe�N�X�`���摜�̃s�N�Z���F���擾���ďo��
	outDiffuse = g_Texture.Sample(g_SamplerState, In.TexCoord);

	//���_�̐F�ƃe�N�X�`���̐F������
	outDiffuse *= In.Diffuse;

	//�F�̔��]
	/*outDiffuse = 1.0f - g_Texture.Sample(g_SamplerState, In.TexCoord);*/

	//�O���[�X�P�[��(�s�N�Z���𖾓x0~1�ŕ\��)
	//R:G:B = 3:6:1�@���炢�̊����ō�������
	outDiffuse = TEXTURECOLOR;
	outDiffuse = 
		0.299*outDiffuse.r +
		0.587*outDiffuse.g +
		0.114*outDiffuse.b;

	//�Z�s�A�ϊ�
	//outDiffuse = TEXTURECOLOR;
	//outDiffuse = 0.299 * outDiffuse.r + 0.587 * outDiffuse.g + 0.114 * outDiffuse.b;
	//float4 sepia = float4(1.07, 0.74, 0.43, 1.0f);
	//outDiffuse *= sepia;


	//RGB�̐F�����ւ���
	//float4 color = TEXTURECOLOR;
	//outDiffuse.r = color.b;
	//outDiffuse.g = color.g;
	//outDiffuse.b = color.r;



	outDiffuse.a = 1.0f;
}