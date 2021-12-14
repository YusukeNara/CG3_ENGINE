#include "OBJShaderHeader.hlsli"

Texture2D<float4> tex : register(t0);  // 0番スロットに設定されたテクスチャ
SamplerState smp : register(s0);      // 0番スロットに設定されたサンプラー

float4 main(VSOutput input) : SV_TARGET
{
    //float3 light = normalize(float3(1, -1, 1)); // 右下奥　向きのライト
    //float light_diffuse = saturate(dot(-light, input.normal));
    //float3 shade_color;
    //shade_color = m_ambient; // アンビエント項
    //shade_color += m_diffuse * light_diffuse; // ディフューズ項
    //float4 texcolor = tex.Sample(smp, input.uv);
    //return float4(texcolor.rgb * shade_color, texcolor.a * m_alpha);

    //テクスチャマッピング
    float4 texColor = tex.Sample(smp, input.uv);
    
    //シェーディング色
    float4 shaderColor;
    //光沢度
    const float shininess = 4.0f;
    //頂点から視点への法線ベクトル
    float3 eyedir = normalize(campos - input.worldpos.xyz);
    //ライトに向かうベクトルと法線の内積
    float3 dotLightNormal1 = dot(lightv, input.normal);
    float3 dotLightNormal2 = dot(lightv2, input.normal);
    //反射光ベクトル
    float3 reflect1 = normalize(-lightv + 2 * dotLightNormal1 * input.normal);
    float3 reflect2 = normalize(-lightv2 + 2 * dotLightNormal2 * input.normal);
    //環境反射
    float3 ambient = m_ambient;
    
    //拡散反射
    float3 diffuse = dotLightNormal1 * m_diffuse;
    float3 diffuse2 = dotLightNormal2 * m_diffuse;
    
    //鏡面反射
    float3 specular = pow(saturate(dot(reflect1, eyedir)), shininess) * m_specular;
    float3 specular2 = pow(saturate(dot(reflect2, eyedir)), shininess) * m_specular;
    
    float3 shade1 = (ambient + diffuse + specular) * lightcolor;
    float3 shade2 = (ambient + diffuse2 + specular2) * lightColor2;
    //すべて加算
    shaderColor.rgb = shade1 + shade2;
    shaderColor.a = m_alpha;
    
    return shaderColor * texColor;
}