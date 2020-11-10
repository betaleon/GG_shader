#include "common.hlsl"

Texture2D g_Texture : register(t0);
SamplerState g_SamplerState : register(s0);

void main(in PS_IN In, out float4 outDiffuse : SV_Target)
{
	float4 normal = normalize(In.Normal);						//��]��̖@���𐳋K������
	float light = -dot(normal.xyz, Light.Direction.xyz) ;

	//�e�N�X�`���̃s�N�Z���F���擾
	outDiffuse = g_Texture.Sample(g_SamplerState, In.TexCoord);
	outDiffuse.rgb *= In.Diffuse.rgb*light;	//���_�F�Ɩ��邳����Z
	outDiffuse.a *= In.Diffuse.a;			//a�ɖ��邳�͊֌W�Ȃ��̂ŕʌv�Z

	//�J��������s�N�Z���ւ̃x�N�g��
	float3 eyev = In.WorldPosition.xyz - CameraPosition.xyz;
	eyev = normalize(eyev);	//���K������

	//--------------------------------------------//
	//				�������C�e�B���O				  //
	//--------------------------------------------//
	float rim = 1.0 + dot(eyev, normal.xyz); //�����Ɩ@���̓��ς𖾂邳�ɕϊ�����
	rim = pow(rim, 3) * 2.0f; //�X�y�L�����Ɠ����悤�ȏ�����K���ɍs���B
	rim = saturate(rim); //rim���T�`�����[�g����
	outDiffuse.rgb += rim; //�ʏ�̐F�։��Z����B
	outDiffuse.a = In.Diffuse.a;
}