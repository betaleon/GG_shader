#include "common.hlsl"

Texture2D g_Texture : register(t0);
//Texture2D g_ToonTexture : register(t1);//�e�N�X�`��1�Ԃ��g��
Texture2D g_TextureEnv : register(t1);
SamplerState g_SamplerState : register(s0);

void main(in PS_IN In, out float4 outDiffuse : SV_Target)
{
	float4 normal = normalize(In.Normal);						//��]��̖@���𐳋K������
	float light = -dot(normal.xyz, Light.Direction.xyz) ;

	//���̃s�N�Z���̖@���}�b�v�̃f�[�^RGBA���擾
	float4 normalMap = g_TextureEnv.Sample(g_SamplerState, In.TexCoord);

	//�擾����RGBA���x�N�g��XYZW�֖߂�
	normalMap = -(normalMap * 2.0f - 1.0f);


	//�J��������s�N�Z���ւ̃x�N�g��
	float3 eyev = In.WorldPosition.xyz - CameraPosition.xyz;
	eyev = normalize(eyev);	//���K������

	//--------------------------------------------//
	//				�t�H�����ʔ���				  //
	//--------------------------------------------//
	//�@���Ō�����\���ʂŔ��˂����x�N�g���̌v�Z
	float3 refv = reflect(Light.Direction.xyz, normal.xyz);	//���̔��˃x�N�g�����v�Z
	refv = normalize(refv);	//���K������


	//���}�b�s���O
	float2 envTexCoord;	//�e�N�X�`�����W
	envTexCoord.x = -refv.x * 0.3f + 0.5f;
	envTexCoord.y = -refv.y * 0.3f + 0.5f;

	float specular = -dot(eyev, refv);	//���ʔ��˂̌v�Z
	specular = saturate(specular);		//�l���T�`�����[�g
	specular = pow(specular, 30);		//�����ł�30�悵�Ă݂�

	outDiffuse = g_TextureEnv.SampleBias(g_SamplerState, envTexCoord, 0.0);

	outDiffuse.rgb += specular;	//�X�y�L�������f�B�t���[�Y�Ƃ��đ�������

	outDiffuse.a = 1.0f;

}