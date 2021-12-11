using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MainSceneButton : MonoBehaviour
{
    public void ChoiseLevel(int index)
    {
        MainSceneManager.instance.ChoiseLevel(index);
    }

}
