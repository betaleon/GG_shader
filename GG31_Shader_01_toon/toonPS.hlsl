#include "common.hlsl"

Texture2D g_Texture : register(t0);
Texture2D g_ToonTexture : register(t1);//�e�N�X�`��1�Ԃ��g��
SamplerState g_SamplerState : register(s0);

void main(in PS_IN In, out float4 outDiffuse : SV_Target)
{
	float4 normal = normalize(In.Normal);						//��]��̖@���𐳋K������
	float light = -dot(normal.xyz, Light.Direction.xyz) ;

	if (light <= 0.0f)
	{
		light = 0.0f;
	}
	else if (0.0f <= light && light < 0.5f)
	{
		light = 0.5f;
	}
	else if (0.5f <= light && light <= 0.9f)
	{
		light = 0.9f;
	}
	else
	{
		light = 1.0f;
	}

	//�e�N�X�`���̃s�N�Z���F���擾
	outDiffuse = g_Texture.Sample(g_SamplerState, In.TexCoord);
	outDiffuse.rgb *= In.Diffuse.rgb*light;	//���_�F�Ɩ��邳����Z
	outDiffuse.a *= In.Diffuse.a;			//a�ɖ��邳�͊֌W�Ȃ��̂ŕʌv�Z

	//�J��������s�N�Z���ւ̃x�N�g��
	float3 eyev = In.WorldPosition.xyz - CameraPosition.xyz;
	eyev = normalize(eyev);	//���K������

	//--------------------------------------------//
	//				�t�H�����ʔ���				  //
	//--------------------------------------------//
	//�@���Ō�����\���ʂŔ��˂����x�N�g���̌v�Z
	float3 refv = reflect(Light.Direction.xyz, normal.xyz);	//���̔��˃x�N�g�����v�Z
	refv = normalize(refv);	//���K������

	float specular = -dot(eyev, refv);	//���ʔ��˂̌v�Z
	specular = saturate(specular);		//�l���T�`�����[�g
	specular = pow(specular, 30);		//�����ł�30�悵�Ă݂�

	outDiffuse.rgb += specular;	//�X�y�L�������f�B�t���[�Y�Ƃ��đ�������

	//--------------------------------------------//
	//				�������C�e�B���O			  //
	//--------------------------------------------//
	float rim = 0.0f + dot(eyev, normal.xyz); //�����Ɩ@���̓��ς𖾂邳�ɕϊ�����
	rim = pow(rim, 3) * 2.0f; //�X�y�L�����Ɠ����悤�ȏ�����K���ɍs���B
	rim = saturate(rim); //rim���T�`�����[�g����

	outDiffuse.rgb += rim; //�ʏ�̐F�։��Z����B
	outDiffuse.a = In.Diffuse.a;

}