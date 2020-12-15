#include "common.hlsl"

Texture2D g_Texture : register(t0);//�e�N�X�`��0�Ԃ��g��
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
	eyev = normalize(eyev);					//���K������

	//--------------------------------------------//
	//				�t�H�����ʔ���				  //
	//--------------------------------------------//
	//�@���Ō�����\���ʂŔ��˂����x�N�g���̌v�Z
	float3 refv = reflect(Light.Direction.xyz, normal.xyz);	//���̔��˃x�N�g�����v�Z
	refv = normalize(refv);	//���K������
	
	float specular = -dot(eyev, refv);	//���ʔ��˂̌v�Z
	specular = saturate(specular);		//�l���T�`�����[�g
	specular = pow(specular, 50);		//�����ł�30�悵�Ă݂�
	
	outDiffuse.rgb += specular;	//�X�y�L�������f�B�t���[�Y�Ƃ��đ�������

	//Texture���p��ToonShader
	////�e�N�X�`���̐F���擾
	//outDiffuse = g_Texture.sample(g_SamplerState, In.TexCoord);
	//outDiffuse *= In.Diffuse.a;//���l�̏���
	//
	////�����v�Z(�n�[�t�����o�[�g)
	//float4 normal = normalize(In.Normal);
	//float light = 0.5 - dot(normal.xyz, Light.Direction.xyz)*0.5;
	//
	////------------------------------
	//
	////���邳�����ƂɃe�N�X�`�����擾
	//light = clamp(light, 0.05f, 0.95f);
	//
	////col���邳�����ƂɃe�N�X�`�����擾
	//float4 col = g_ToonTexture.Sample(g_SamplerState, float2(light, 0.5f));
	//
	////col�𖾂邳�Ƃ��ď���
	//outDiffuse.rgb *= In.Diffuse.rgb * col.rgb;	//�e�N�X�`��*���_�F*���邳

}