using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum EffectType
{
    Cake,
    Socola,
    Chili,
    Soap
}

public class EatEffect : MonoBehaviour
{
    public GameObject[] effect;
    public void Set(EffectType type)
    {
        foreach (var i in effect)
        {
            i.SetActive(false);
        }
        effect[(int)type].SetActive(true);
    }


}
