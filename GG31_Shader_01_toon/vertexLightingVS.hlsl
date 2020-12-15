#include "common.hlsl"

void main(in VS_IN In, out PS_IN Out)
{
	//���_�@�������[���h�s��ŉ�]������(���_�Ɠ�����]��������)
	float4 worldNormal, normal;	//���[�J���ϐ����쐬

	normal = float4(In.Normal.xyz,0.0);			//�@���x�N�g����w��0�Ƃ���(�s�����Z���Ă����s�ړ����Ȃ�)
	worldNormal = mul(normal,World);				//�@�������[���h�s��ŉ�]
	worldNormal = normalize(worldNormal);			//��]��̖@���𐳋K������

	//�����v�Z�̏������������� ���邳�̌v�Z
	float light = -dot(Light.Direction.xyz, worldNormal.xyz);	//���x�N�g���Ɩ@���̓��� XYZ�v�f�݂̂Ōv�Z
	light = saturate(light);									//���邳��0~1�̊ԂŖO�a������

	Out.Diffuse = light;		//���邳�𒸓_�F�Ƃ��ďo��
	Out.Diffuse = In.Diffuse.a;	//�O�̂���

	matrix wvp;
	wvp = mul(World, View);
	wvp = mul(wvp, Projection);	//�ϊ��s��쐬
	
	Out.Position = mul(In.Position, wvp);	//���_�o��
	Out.Normal = worldNormal;				//��]��̖@���o�� In.Normal�ł͂Ȃ���]��̂��̂��o��
	Out.TexCoord = In.TexCoord;				//�e�N�X�`�����W�o��


}