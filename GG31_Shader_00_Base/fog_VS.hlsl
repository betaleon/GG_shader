/*
#include "common.hlsl"

void main(	in float4 inPosition   : POSITION0,
			in float4 inNormal     : NORMAL0,
			in float4 inDiffuse	   : COLOR0,
			in float2 inTexCoord   : TEXCOORD0,
	
			out float2 outTexCoord : TEXCOORD0,
			out float4 outDiffuse  : COLOR0,
			out float4 outPosition : SV_POSITION,
			out float4 outNormal   : NORMAL0,
			out float  outDepth    : DEPTH)
{
	matrix wvp;
	wvp = mul(World, View);
	wvp = mul(wvp, Projection);				//�ϊ��s��쐬

	outPosition = mul(inPosition, wvp);		//���_��ϊ����ďo��
	outNormal = inNormal;
	outTexCoord = inTexCoord;

	outDepth = 1 - saturate((50 - outPosition.w) / (50 - 0.1F));

	//float4 worldNormal, normal;				//�@�������[���h�s��ŉ�]
	//normal = float4(In.Normal.xyz, 0.0f);
	//worldNormal = mul(normal, World);
	//
	//worldNormal = normalize(worldNormal);	//�ϊ������@���𐳋K��
	//Out.Normal = worldNormal;				//���[���h�ϊ������@�����o��
	//
	//Out.Diffuse = In.Diffuse;
	//Out.TexCoord = In.TexCoord;
	//
	//Out.WorldPosition = mul(In.Position, World);	//���[���h �ϊ��������_���W�� �o��
}*/