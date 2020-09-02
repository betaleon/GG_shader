#pragma once

class CPlayer
{

private:
	D3DXVECTOR3	m_Position;
	D3DXVECTOR3	m_Rotation;
	D3DXVECTOR3	m_Scale;

	CModel* m_Model;

public:
	void Init();
	void Uninit();
	void Update();
	void Draw();

};