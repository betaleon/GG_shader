//�s�N�Z���V�F�[�_�[
#include "common.hlsl"

void main(in PS_IN In, out float4 outDiffuse : SV_Target)
{
	//���͂��ꂽ�F�����̂܂܃s�N�Z���F�Ƃ��ďo��
	outDiffuse = In.Diffuse;

}