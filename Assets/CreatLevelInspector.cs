using UnityEngine;
using System.Collections;
using UnityEditor;

public class CreatLevelInspector : MonoBehaviour
{
    public GameObject[] object_list;
    public int objectCount;
    public float objectStep;
    public GameObject cut;
    public void CreatNewLevel()
    {
        
        for (int i = 0; i < objectCount; i++)
        {
            GameObject objec = Instantiate(object_list[Random.Range(0, object_list.Length)]);
            objec.transform.position = new Vector3(0, 0, objectStep * i);
            if (Random.Range(0,99) < 20)
            {
                Instantiate(cut, objec.transform.position, Quaternion.identity);
            }
        }

    }
}