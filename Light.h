#pragma once
#include <Windows.h>
#include <wrl.h>
#include <d3d12.h>
#include <DirectXMath.h>
#include <d3dx12.h>

class Light
{
private: // エイリアス
// Microsoft::WRL::を省略
	template <class T> using ComPtr = Microsoft::WRL::ComPtr<T>;
	// DirectX::を省略
	using XMFLOAT2 = DirectX::XMFLOAT2;
	using XMFLOAT3 = DirectX::XMFLOAT3;
	using XMFLOAT4 = DirectX::XMFLOAT4;
	using XMVECTOR = DirectX::XMVECTOR;
	using XMMATRIX = DirectX::XMMATRIX;

public://サブクラス
	struct ConstBufferData {
		XMVECTOR lightv;		//ライト方向
		XMFLOAT3 lightColor;	//ライト色
	};

private:
	//デバイス
	static ID3D12Device *dev;

public:
	//初期化
	static void StaticInit(ID3D12Device *device);

	//生成
	static Light *Create();

	//初期化
	void Init();

	//定数バッファデータ転送
	void TransferConstBufferData();

	//ライト方向セット
	void SetLightDir(const XMVECTOR &lightDir);

	//ライト色セット
	void SetLightColor(const XMFLOAT3 &lightColor);

	//更新
	void Update();

	//描画
	void Draw(ID3D12GraphicsCommandList *cmdlist, UINT rootparamIndex);

private:// メンバ変数
	//定数バッファ
	ComPtr<ID3D12Resource> constBuff;
	//ライト光線方向
	XMVECTOR lightDir = { 1,0,0,0 };
	//ライト色
	XMFLOAT3 lightColor = { 1,1,1 };
	//ダーティフラグ
	bool dirty = false;

};

