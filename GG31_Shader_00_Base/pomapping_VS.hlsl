#include "common.hlsl"

void main(in VS_IN In, out PS_IN Out)
{
	//wvp ���[���h�r���[�v���W�F�N�V����
	matrix wvp;
	wvp = mul(World, View);
	wvp = mul(wvp, Projection);				//�ϊ��s��쐬

	Out.Position = mul(In.Position, wvp);	//���_��ϊ����ďo��
	//�@�������[���h�s��ŕϊ�
	float4 worldNormal, normal;				//�@�������[���h�s��ŉ�]
	normal = float4(In.Normal.xyz, 0.0f);
	worldNormal = mul(normal, World);

	worldNormal = normalize(worldNormal);	//�ϊ������@���𐳋K��
	Out.Normal = worldNormal;				//���[���h�ϊ������@�����o��

	Out.Diffuse = In.Diffuse;
	Out.TexCoord = In.TexCoord;

	Out.WorldPosition = mul(In.Position, World);	//���[���h �ϊ��������_���W�� �o��
}