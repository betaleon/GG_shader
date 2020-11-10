//���̃t�@�C���͑��̃V�F�[�_�[�t�@�C���փC���N���[�h���܂�

//�e��}�g���b�N�X�o�b�t�@�@�R���X�^���g�o�b�t�@��`

cbuffer WorldBuffer : register(b0)
{
	matrix World;		//���[���h�s��ϐ�
}

cbuffer ViewBuffer : register (b1)
{
	matrix View;		//�r���[�s��ϐ�
}

cbuffer ProjectionBuffer : register (b2)
{
	matrix Projection;	//�v���W�F�N�V�����s��ϐ�
}

//���_�V�F�[�_�[�֓��͂����f�[�^���\���̂̌`�ŕ\��
//����͒��_�o�b�t�@�̓��e���̂���
struct VS_IN
{
	float4 Position	:	POSITION0;	//���_���W
	float4 Normal	:	NORMAL0;	//�@��
	float4 Diffuse	:	COLOR0;		//�J���[
	float2 TexCoord :	TEXCOORD0;	//�e�N�X�`�����W
};
//�s�N�Z���V�F�[�_�[�֓��͂����f�[�^���\���̂̌`�ŕ\��
struct PS_IN
{
	float4 Position			:	SV_POSITION;	//���_���W
	float4 WorldPosition	: POSITION0;
	float4 Normal			:	NORMAL0;		//�@��
	float4 Diffuse			:	COLOR0;			//�J���[
	float2 TexCoord			:	TEXCOORD0;		//�e�N�X�`�����W
};

//���C�g�I�u�W�F�N�g�\���̂ƃR���X�^���g�o�b�t�@
struct LIGHT
{
	bool Enable;
	bool3 Dummy;		//4�̔{���ɂ���ƌ����������̂Œ����p�A����C����ł���������VS2017������Ă���Ă���
	float4 Direction;
	float4 Diffuse;
	float4 Ambient;

};

cbuffer LightBuffer : register(b4)	//�R���X�^���g�o�b�t�@4�ԂƂ���
{
	LIGHT Light;			//���C�g�\����
}

cbuffer CameraBuffer : register(b5)	//�o�b�t�@��5�ԂƂ���
{
	float4	CameraPosition;	//�J�������W���󂯎��ϐ�
}