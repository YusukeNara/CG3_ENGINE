#pragma once
#include <Windows.h>
#include <wrl.h>
#include <d3d12.h>
#include <DirectXMath.h>
#include <d3dx12.h>

class Light
{
private: // �G�C���A�X
// Microsoft::WRL::���ȗ�
	template <class T> using ComPtr = Microsoft::WRL::ComPtr<T>;
	// DirectX::���ȗ�
	using XMFLOAT2 = DirectX::XMFLOAT2;
	using XMFLOAT3 = DirectX::XMFLOAT3;
	using XMFLOAT4 = DirectX::XMFLOAT4;
	using XMVECTOR = DirectX::XMVECTOR;
	using XMMATRIX = DirectX::XMMATRIX;

public://�T�u�N���X
	struct ConstBufferData {
		XMVECTOR lightv;		//���C�g����
		XMFLOAT3 lightColor;	//���C�g�F
	};

private:
	//�f�o�C�X
	static ID3D12Device *dev;

public:
	//������
	static void StaticInit(ID3D12Device *device);

	//����
	static Light *Create();

	//������
	void Init();

	//�萔�o�b�t�@�f�[�^�]��
	void TransferConstBufferData();

	//���C�g�����Z�b�g
	void SetLightDir(const XMVECTOR &lightDir);

	//���C�g�F�Z�b�g
	void SetLightColor(const XMFLOAT3 &lightColor);

	//�X�V
	void Update();

	//�`��
	void Draw(ID3D12GraphicsCommandList *cmdlist, UINT rootparamIndex);

private:// �����o�ϐ�
	//�萔�o�b�t�@
	ComPtr<ID3D12Resource> constBuff;
	//���C�g��������
	XMVECTOR lightDir = { 1,0,0,0 };
	//���C�g�F
	XMFLOAT3 lightColor = { 1,1,1 };
	//�_�[�e�B�t���O
	bool dirty = false;

};

