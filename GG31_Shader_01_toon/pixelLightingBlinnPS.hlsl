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
	//			  �u�����t�H�����ʔ���			  //
	//--------------------------------------------//
	//�n�[�t�x�N�g���̍쐬
	float3 halfv = eyev + Light.Direction.xyz;
	halfv = normalize(halfv);
	
	float specular = -dot(halfv, normal.xyz); //�n�[�t�x�N�g���Ɩ@���̓��ς��v�Z
	specular = saturate(specular);
	specular = pow(specular, 30);

	outDiffuse.rgb += specular;	//�X�y�L�������f�B�t���[�Y�Ƃ��đ�������


	}