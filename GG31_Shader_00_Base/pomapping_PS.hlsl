#include "common.hlsl"

Texture2D g_Texture			: register(t0);
Texture2D g_TextureNormal   : register(t1);						//�@���}�b�v
SamplerState g_SamplerState : register(s0);
sampler g_Texture1			: register(s1);

void main(in PS_IN In, out float4 outDiffuse : SV_Target)
{
	//���̃s�N�Z���̖@���}�b�v�̃f�[�^RGBA���擾
	float4 normalMap = g_TextureNormal.Sample(g_SamplerState, In.TexCoord);

	//�擾����RGBA���x�N�g��XYZW�֖߂�
	normalMap = normalMap * 2.0f - 1.0f;

	//�e�N�X�`���̃f�[�^��@���p�ϐ��֓���ւ�
	float3 normal;
	normal.x = normalMap.x;
	normal.y = normalMap.y;
	normal.z = normalMap.z;
	normal = normalize(normal);	//���K��

	//�ȉ��̓t�H���Ƃ��u�����t�H���Ƃ��̌����v�Z

	float light = dot(normal.xyz, Light.Direction.xyz);
	light += 0.5f;

	//�e�N�X�`���̃s�N�Z���F���擾
	outDiffuse = g_Texture.Sample(g_SamplerState, In.TexCoord);
	outDiffuse.rgb *= In.Diffuse.rgb*light;						//���_�F�Ɩ��邳����Z
	outDiffuse.a *= In.Diffuse.a;								//a�ɖ��邳�͊֌W�Ȃ��̂ŕʌv�Z

	//�J��������s�N�Z���ւ̃x�N�g��
	float3 eyev = In.WorldPosition.xyz - CameraPosition.xyz;
	eyev = normalize(eyev);										//���K������


	//�X�N���[����Ԃ�x,y���W�ɂ��āAx.y�̌��z���擾
	float2 dx, dy;
	dx = ddx(In.TexCoord);
	dy = ddy(In.TexCoord);
	//�e�N�Z���̃T���v�����O�ʒu�̃I�t�Z�b�g�l�𒲐�
	float2  offset = eyev.xy * 0.003f;
	//�e�N�Z���̃T���v�����O�ʒu
	float2 texel = In.TexCoord;

	float height = 0.0f;

	bool flg = false;
	while (!flg)
	{
		float4 NormalMap = tex2Dgrad(g_Texture1, texel, dx, dy);
		//
		////�����Ŕ�r����
		//if (NormalMap.a * 0.03f <= height)
		//{
		//	//�@���x�N�g�����擾
		//	float3 Normal = 2.0f * NormalMap.rgb - 1.0f;
		//
		//	//�n�[�t�����o�[�g�g�U�Ɩ�
		//	float color = dot(Normal, light);
		//	color = color * 0.5f + 0.5f;
		//	color = color * color;
		//
		//	outDiffuse = tex2Dgrad(g_SamplerState, texel, dx, dy) * color;
		//
		//	//���[�v�I��
		//	flg = true;
		//}
		//texel += offset;
		//height += eyev.z * 0.003f;
		flg = true;
	}



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